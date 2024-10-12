# 경로 미지정 도커파일
#FROM openjdk:18-alpine
#LABEL maintainer="pc-1"
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
#RUN mkdir -p target/dependency && (cd target/dependency; jar -xf / app.jar)
#
#ENTRYPOINT ["java", "-jar", "/app.jar"]

######################################################################
#경로 강제지정 도커파일(컨테이너 실행 테스트 완료)
#FROM openjdk:18-alpine
#LABEL maintainer="pc-1"
## JAR 파일 경로를 명시적으로 지정
#ARG JAR_FILE=build/libs/licensing-service-0.0.1-SNAPSHOT.jar
#
## JAR 파일을 컨테이너로 복사
#COPY ${JAR_FILE} /app/app.jar
#
## JAR 파일을 실행
#ENTRYPOINT ["java", "-jar", "/app/app.jar"]

#######################################################################
# 와일드 카드를 사용한 도커파일(이미지 빌드 시 에러가 날 수 있음)
#FROM openjdk:18-alpine
#LABEL maintainer="pc-1"
#
## 빌드 중 제공되는 JAR 파일 경로를 처리할 수 있도록 ARG 설정
#ARG JAR_FILE=build/libs/*.jar
#
## JAR 파일을 /app/app.jar로 복사
#COPY ${JAR_FILE} /app/app.jar
#
## JAR 파일을 실행
#ENTRYPOINT ["java", "-jar", "/app/app.jar"]

########################################################################
# 레이어 구성 추가 버전

# 첫 번째 스테이지 (빌드 스테이지)
FROM openjdk:18-alpine AS build
WORKDIR /application

# JAR 파일 경로 설정 (정확한 경로 지정)
ARG JAR_FILE=build/libs/licensing-service-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} application.jar

# 레이어 추출
RUN java -Djarmode=layertools -jar application.jar extract

# 두 번째 스테이지 (최종 이미지 빌드)
FROM openjdk:18-alpine
WORKDIR /application

# 각 레이어를 절대 경로로 복사
COPY --from=build /application/dependencies/ ./
COPY --from=build /application/spring-boot-loader/ ./
COPY --from=build /application/snapshot-dependencies/ ./
COPY --from=build /application/application/ ./

# JAR 파일 실행
# ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]