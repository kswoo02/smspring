<%-- admin/src/main/webapp/views/inquiry.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    /* 스타일은 이전 답변과 동일 */
</style>

<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">1:1 문의</h1>
    </div>
    <div id="connection_status" style="color: red;">Connecting to Chat Server...</div>

    <div class="row d-none d-md-flex">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Inquiry Chat</h6>
                </div>
                <div id="customer_list" class="card-body chat-scroll"></div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 id="current_customer_id" class="m-0 font-weight-bold text-primary">Answer Chat</h6>
                </div>
                <div id="chat_messages" class="card-body chat-scroll"></div>
                <div class="card-footer">
                    <div class="input-group">
                        <%-- [MODIFIED] disabled 속성 추가 --%>
                        <input type="text" id="message_input" class="form-control" placeholder="Type a message..." disabled>
                        <div class="input-group-append">
                            <button id="send_button" class="btn btn-primary" disabled>Send</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    $(document).ready(function() {
        let stompClient = null;
        let activeCustomers = new Set();
        let selectedCustomer = null;

        // [MODIFIED] shop 서버의 주소를 명시적으로 설정합니다. (포트 번호 확인 필수)
        const shopServerUrl = 'http://127.0.0.1:8080';

        function connect() {
            // [MODIFIED] shop 서버 URL로 접속
            const socket = new SockJS(shopServerUrl + '/ws');
            stompClient = Stomp.over(socket);

            const onConnect = (frame) => {
                console.log('Connected: ' + frame);
                $('#connection_status').text('Connected to Chat Server').css('color', 'green');

                // 모든 고객으로부터 오는 메시지를 구독하여 고객 목록 업데이트
                stompClient.subscribe('/topic/receiveto/admin', function (message) {
                    const msg = JSON.parse(message.body);
                    if (!activeCustomers.has(msg.sendid)) {
                        activeCustomers.add(msg.sendid);
                        renderCustomerList();
                    }
                });
            };

            const onError = (error) => {
                console.error('Connection error: ' + error);
                $('#connection_status').text('Chat Server Connection failed.');
            };

            stompClient.connect({}, onConnect, onError);
        }

        function renderCustomerList() {
            $("#customer_list").empty();
            activeCustomers.forEach(customer => {
                const customerDiv = $("<div class='chat-msg customer-item' data-id='" + customer + "'><p>" + customer + " 님의 문의</p></div>");

                customerDiv.click(() => {
                    if (selectedCustomer === customer) return;
                    selectedCustomer = customer;

                    $(".customer-item").removeClass("active");
                    customerDiv.addClass("active");
                    $("#current_customer_id").text(customer + "님과의 대화");
                    $("#chat_messages").empty();
                    $('#message_input').prop('disabled', false);
                    $('#send_button').prop('disabled', false);

                    // 기존 구독 해제 후, 특정 고객과의 대화 채널만 구독
                    if(stompClient.subscriptions){
                        for(const sub in stompClient.subscriptions){
                            if(sub.startsWith('/topic/sendto/admin')){
                                stompClient.unsubscribe(sub);
                            }
                        }
                    }
                    stompClient.subscribe('/topic/sendto/admin', function (message) {
                        const msg = JSON.parse(message.body);
                        if(msg.sendid === selectedCustomer){
                            showMessage(msg, 'received');
                        }
                    });

                });
                $("#customer_list").append(customerDiv);
            });
        }

        function sendMessage() {
            const messageContent = $("#message_input").val();
            if (messageContent && stompClient && stompClient.connected && selectedCustomer) {
                const chatMessage = {
                    sendid: 'admin',
                    receiveid: selectedCustomer,
                    content1: messageContent
                };
                stompClient.send("/app/sendto", {}, JSON.stringify(chatMessage));