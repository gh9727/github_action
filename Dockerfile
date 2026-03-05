#FROM amazoncorretto:17-alpine-jdk
## plain이 붙지 않은 실행 가능한 jar 하나만 지정해서 복사
#COPY build/libs/*-SNAPSHOT.jar app.jar
#ENTRYPOINT ["java", "-jar", "/app.jar"]


# 1. 빌드 스테이지 (기존 작성하신 내용)
FROM gradle:8.5-jdk17 AS builder
WORKDIR /build

# 캐시 활용을 위해 설정 파일 먼저 복사
COPY build.gradle settings.gradle /build/
RUN gradle dependencies --no-daemon

# 소스 전체 복사 및 JAR 빌드
COPY . /build
RUN gradle build -x test --parallel --no-daemon

# ---------------------------------------------------------

# 2. 실행 스테이지 (새로 추가할 내용)
# 실행할 때는 무거운 Gradle이 필요 없으므로 가벼운 JRE 환경만 사용합니다.
FROM amazoncorretto:17-alpine-jdk

WORKDIR /app

# 빌드 스테이지(builder)에서 생성된 jar 파일만 쏙 빼와서 복사합니다.
# [주의] build.gradle의 프로젝트명과 버전이 파일 이름이 됩니다.
COPY --from=builder /build/build/libs/git_action-0.0.1-SNAPSHOT.jar app.jar

# 컨테이너가 사용할 포트 번호 (Spring Boot 기본 8080)
EXPOSE 8080

# 애플리케이션 실행 명령어
# -Djava.security.egd... 는 컨테이너 환경에서 난수 생성 속도를 높여 실행을 빠르게 돕습니다.
ENTRYPOINT ["java", "-jar", "-Djava.security.egd=file:/dev/./urandom", "app.jar"]