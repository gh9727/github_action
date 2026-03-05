package com.sparta.git_action;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExamController {
    @GetMapping("/api/v1")
    public String getDockerConnect() {
        return "도커파일을 빌드해서 도커 이미지 생성 후 생성된 이미지를 도커 허브에 올리고" +
                "aws에 도커 설정해서 내가 도커 허브에 올린 도커 이미지를 받아와 실행시킨다";
    }

    @GetMapping("/git/action")
    public String getGitAction() {
        return "gitHub_Action을 사용해서 자동 배포를 성공했다!";
    }

    @GetMapping("/git/action/error")
    public String getGitActionError() {
        return "gitHub_Action 에러나지마 ,,";
    }
    @GetMapping("/git/action/test")
    public String getGitActionTest() {
        return "20260305 git_action 작동 유무 테스트";
    }
}