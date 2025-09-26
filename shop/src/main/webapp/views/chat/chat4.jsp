<%-- shop/src/main/webapp/views/chat4.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 스타일은 이전 답변과 동일 */
    #chat_container { width: 400px; border: 1px solid #ccc; padding: 10px; }
    #chat_messages { height: 300px; border: 1px solid #eee; overflow-y: scroll; padding: 5px; margin-bottom: 10px; }
    .message { margin-bottom: 5px; }
    .sent { text-align: right; color: blue; }
    .received { text-align: left; color: green; }
</style>

<div id="chat_container">
    <h4>고객 문의</h4>
    <div id="connection_status" style="color: red;">Connecting...</div>
    <div id="chat_messages"></div>
    <%-- [MODIFIED] disabled 속성 추가 --%>
    <input type="text" id="message_input" style="width: 300px;" disabled />
    <button id="send_button" disabled>Send</button>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    $(document).ready(function() {
        let stompClient = null;
        const customerId = "${sessionScope.cust.custId}" || "guest" + new Date().getTime(); // 세션이 없으면 임시 ID

        function connect() {
            const socket = new SockJS('/ws'); // shop 서버의 WebSocket 엔드포인트
            stompClient = Stomp.over(socket);

            // [MODIFIED] 연결 성공/실패 콜백 분리
            const onConnect = (frame) => {
                console.log('Connected: ' + frame);
                $('#connection_status').text('Connected').css('color', 'green');
                $('#message_input').prop('disabled', false);
                $('#send_button').prop('disabled', false);

                // 관리자로부터 오는 개인 메시지 구독
                stompClient.subscribe('/topic/sendto/' + customerId, function (message) {
                    showMessage(JSON.parse(message.body), 'received');
                });
            };

            const onError = (error) => {
                console.error('Connection error: ' + error);
                $('#connection_status').text('Connection failed. Please refresh.');
            };

            stompClient.connect({}, onConnect, onError);
        }

        function sendMessage() {
            const messageContent = $("#message_input").val();
            if (messageContent && stompClient && stompClient.connected) {
                const chatMessage = {
                    sendid: customerId,
                    receiveid: 'admin',
                    content1: messageContent
                };

                // [MODIFIED] 두 개의 목적지로 메시지 전송
                // 1. 관리자 목록에 알리기 위한 메시지
                stompClient.send("/app/receiveto", {}, JSON.stringify(chatMessage));
                // 2. 실제 대화를 위한 메시지 (관리자가 구독할 채널)
                stompClient.send("/app/sendto", {}, JSON.stringify(chatMessage));

                showMessage(chatMessage, 'sent');
                $("#message_input").val('');
            }
        }

        function showMessage(message, type) {
            const messageClass = (type === 'sent') ? 'sent' : 'received';
            $("#chat_messages").append(
                "<div class='message " + messageClass + "'>" +
                "<b>" + message.sendid + ":</b> " + message.content1 +
                "</div>"
            );
            $("#chat_messages").scrollTop($("#chat_messages")[0].scrollHeight);
        }

        $("#send_button").click(sendMessage);
        $("#message_input").keypress(function(e) {
            if (e.which === 13) sendMessage();
        });

        connect();
    });
</script>