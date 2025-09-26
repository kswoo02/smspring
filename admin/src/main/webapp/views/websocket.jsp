<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  .admin-webrtc-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }
  .video-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 20px;
  }
  .video-wrapper {
    position: relative;
    width: 100%;
    background: #000;
    border-radius: 8px;
    overflow: hidden;
  }
  .video-stream {
    width: 100%;
    height: auto;
    aspect-ratio: 16/9;
  }
  .video-label {
    position: absolute;
    bottom: 10px;
    left: 10px;
    color: white;
    background: rgba(0, 0, 0, 0.5);
    padding: 5px 10px;
    border-radius: 4px;
  }
  .controls {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin: 20px 0;
  }
  .control-button {
    padding: 10px 20px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-size: 16px;
  }
  .start-call {
    background: #4CAF50;
    color: white;
  }
  .end-call {
    background: #f44336;
    color: white;
  }
  .connection-status {
    text-align: center;
    font-size: 14px;
  }
</style>
<script>
  chat3 = {
    roomId: '1', // 하드코딩된 방 번호
    peerConnection:null,
    localStream:null,
    websocket:null,
    configuration: {
      iceServers: [{
        urls: 'stun:stun.l.google.com:19302'
      }]
    },
    init:async function(){
      try {
        this.websocket = new WebSocket('${websocketurl}signal');

        $('#startButton').click(()=>{
          this.startCall();
        });
        $('#endButton').click(()=>{
          this.endCall();
        });

        this.websocket.onopen = () => {
          console.log('WebSocket connected');
          this.updateConnectionStatus('WebSocket Connected');
          this.sendSignalingMessage({
            type: 'join',
            roomId: this.roomId
          });

        };
        const stream = await navigator.mediaDevices.getUserMedia({
          video: {
            width: { ideal: 1280 },
            height: { ideal: 720 }
          },
          audio: true
        });

        this.localStream = stream;
        document.getElementById('localVideo').srcObject = stream;
        document.getElementById('startButton').disabled = false;

        this.setupWebSocketHandlers();
      } catch (error) {
        console.error('Error initializing WebRTC:', error);
        this.updateConnectionStatus('Error: ' + error.message);
      }

    },
    startCall:async function(){
      try {
        if (!this.peerConnection) {
          await this.createPeerConnection();
        }

        const offer = await this.peerConnection.createOffer();
        await this.peerConnection.setLocalDescription(offer);

        this.sendSignalingMessage({
          type: 'offer',
          data: offer,
          roomId: this.roomId
        });

        document.getElementById('startButton').style.display = 'none';
        document.getElementById('endButton').style.display = 'block';
      } catch (error) {
        console.error('Error starting call:', error);
        this.updateConnectionStatus('Error starting call');
      }

    },
    endCall:function(){
      if (this.localStream) {
        this.localStream.getTracks().forEach(track => track.stop());
      }
      if (this.peerConnection) {
        this.peerConnection.close();
        this.peerConnection = null;
      }
      document.getElementById('remoteVideo').srcObject = null;
      document.getElementById('startButton').style.display = 'block';
      document.getElementById('endButton').style.display = 'none';
      this.updateConnectionStatus('Call Ended');

    },
    sendSignalingMessage:function(message){
      if (this.websocket?.readyState === WebSocket.OPEN) {
        this.websocket.send(JSON.stringify(message));
      }
    },
    setupWebSocketHandlers:function(){
      this.websocket.onmessage = async (event) => {
        try {
          const message = JSON.parse(event.data);
          console.log('Received message:', message.type);

          switch (message.type) {
            case 'offer':
              try {
                if (!this.peerConnection) {
                  await this.createPeerConnection();
                }

                await this.peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
                const answer = await this.peerConnection.createAnswer();
                await this.peerConnection.setLocalDescription(answer);

                this.sendSignalingMessage({
                  type: 'answer',
                  data: answer,
                  roomId: this.roomId
                });
              } catch (error) {
                console.error('Error handling offer:', error);
              }              break;
            case 'answer':
              await this.peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
              break;
            case 'ice-candidate':
              await this.peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
              break;
          }
        } catch (error) {
          console.error('Error handling WebSocket message:', error);
        }
      };

      this.websocket.onclose = () => {
        this.updateConnectionStatus('WebSocket Disconnected');
      };

      this.websocket.onerror = (error) => {
        console.error('WebSocket error:', error);
        this.updateConnectionStatus('WebSocket Error');
      };

    },

    createPeerConnection:function(){
      this.peerConnection = new RTCPeerConnection(this.configuration);

      this.localStream.getTracks().forEach(track => {
        this.peerConnection.addTrack(track, this.localStream);
      });

      this.peerConnection.ontrack = (event) => {
        if (document.getElementById('remoteVideo') && event.streams[0]) {
          document.getElementById('remoteVideo').srcObject = event.streams[0];
        }
      };

      this.peerConnection.onicecandidate = (event) => {
        if (event.candidate) {
          this.sendSignalingMessage({
            type: 'ice-candidate',
            data: event.candidate,
            roomId: this.roomId
          });
        }
      };

      this.peerConnection.onconnectionstatechange = () => {
        this.updateConnectionStatus('Connection: ' + this.peerConnection.connectionState);
      };

      return this.peerConnection;

    },
    updateConnectionStatus:function (status){
      document.getElementById('connectionStatus').textContent = 'Status: ' + status;
    }
  }
  $(()=>{
    chat3.init();
  });

</script>



<div class="col-sm-10">
  <h2>Chat3 Center</h2>

  <div class="admin-webrtc-container">
    <div class="video-grid">
      <div class="video-wrapper">
        <video id="localVideo" autoplay playsinline muted class="video-stream"></video>
        <div class="video-label">Admin Stream</div>
      </div>
      <div class="video-wrapper">
        <video id="remoteVideo" autoplay playsinline class="video-stream"></video>
        <div class="video-label">User Stream</div>
      </div>
    </div>
    <div class="controls">
      <button id="startButton" class="control-button start-call">Start Call</button>
      <button id="endButton" class="control-button end-call" style="display: none;">End Call</button>
    </div>
    <div class="connection-status" id="connectionStatus">
      Status: Disconnected
    </div>
  </div>
</div>