package com.sparta.git_action;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/test")
@RequiredArgsConstructor
public class TestController {

    private final MemberRepository memberRepository;

    // 데이터 저장 테스트
    @PostMapping("/save")
    public String saveMember(@RequestParam String name, @RequestParam String email) {
        Member member = new Member();
        member.setName(name);
        member.setEmail(email);
        memberRepository.save(member);
        return "저장 성공! 이름: " + name;
    }

    // 데이터 조회 테스트
    @GetMapping("/all")
    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }
}