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
