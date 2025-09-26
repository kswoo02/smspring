<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
    .chat-msg{
        position: relative;
        border: 2px solid #dedede;
        background-color: #f1f1f1;
        border-radius: 8px;
        padding: 12px 14px 32px;
        margin: 12px 0;
        overflow: hidden;
    }
    .chat-msg.darker{ border-color:#ccc; background-color:#ddd; }

    .chat-msg img{
        float: left;
        max-width: 60px; width: 100%;
        margin-right: 16px;
        border-radius: 50%;
    }
    .chat-msg img.right{
        float: right;
        margin-left: 16px; margin-right: 0;
    }

    .chat-msg p{
        word-wrap: break-word;
        word-break: break-word;
        white-space: pre-wrap;
        margin: 0;
    }

    .time-right,.time-left{
        position: absolute;
        bottom: 6px;
        font-size: .85rem;
        color: #888;
    }
    .time-right{ right: 10px; }
    .time-left{  left: 10px; }

    .chat-scroll{ max-height:520px; overflow-y:auto; }
    .card{ border-radius:12px; }
</style>

<div class="container-fluid">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Inquiry</h1>
    </div>

    <div class="row d-none d-md-flex">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Inquiry Chat</h6>
                </div>
                <div class="card-body chat-scroll">
                    <div class="chat-msg">
                        <img src="/w3images/bandmember.jpg" alt="Avatar">
                        <p>ddddㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ… dddddd</p>
                        <span class="time-right">11:00</span>
                    </div>
                    <div class="chat-msg">
                        <img src="/w3images/avatar_g2.jpg" alt="Avatar">
                        <p>cccccccccccc</p>
                        <span class="time-right">11:01</span>
                    </div>
                    <div class="chat-msg">
                        <img src="/w3images/bandmember.jpg" alt="Avatar">
                        <p>bbbbbbbb?</p>
                        <span class="time-right">11:02</span>
                    </div>
                    <div class="chat-msg">
                        <img src="/w3images/avatar_g2.jpg" alt="Avatar">
                        <p>aaaaaaaaaa?</p>
                        <span class="time-right">11:03</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Answer Chat</h6>
                </div>
                <div class="card-body chat-scroll">
                    <div class="chat-msg">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
