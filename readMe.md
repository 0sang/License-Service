# 불필요한 과정이 존재할 수 있음(에러가 날 경우 다음 단계를 시도해보자, 안되면 말고)

docker 이미지 생성 (jar파일 생성)
mvn clean package -> ./gradlew clean build
mvn package dockerfile:build → ./gradlew bootBuildImage ?

docker 이미지 빌드(도커에 등록?)
mvn package dockerfile:build → docker build -t ostock/licensing-service:0.0.1-SNAPSHOT .

도커 이미지 확인
docker images

도커 컨테이너 실행
docker run -d -p 8080:8080 ostock/licensing-service:0.0.1-SNAPSHOT
컨테이너 실행 상태 확인
docker ps, 실행했는데 실행되고 있는 컨테이너가 없을 경우 docker ps(종료 로그도 남음)

레이어 활성화 방법
build.gradle
bootJar -> layered {enabled = true} 추가

레이어 활성화 후 레이어 확인 명령어
java -Djarmode=layertools -jar target/licensing-service-0.0.1-SNAPSHOT.jar list -> 
java -Djarmode=layertools -jar build/libs/licensing-service-0.0.1-SNAPSHOT.jar list

이후
1. ./gradlew bootjar
2. docker build . --tag licensing-service
후
3. docker run -it -p8080:8080 licensing-service:latest 명령어 실행 시
Could not find or load main class org.springframework.boot.loader.JarLauncher 에러 발생,
Dockerfile
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"] ->
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
변경 후 재실행(./gradlew bootjar, )