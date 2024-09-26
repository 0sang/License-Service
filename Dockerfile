#FROM openjdk:18-alpine
#LABEL maintainer="pc-1"
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
#RUN mkdir -p target/dependency && (cd target/dependency; jar -xf / app.jar)
#
#ENTRYPOINT ["java", "-jar", "/app.jar"]


FROM openjdk:18-alpine
LABEL maintainer="pc-1"
# JAR 파일 경로를 명시적으로 지정
ARG JAR_FILE=build/libs/licensing-service-0.0.1-SNAPSHOT.jar

# JAR 파일을 컨테이너로 복사
COPY ${JAR_FILE} /app/app.jar

# JAR 파일을 실행
ENTRYPOINT ["java", "-jar", "/app/app.jar"]