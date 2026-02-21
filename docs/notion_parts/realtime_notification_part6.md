## 6) 설정/문서화

- 설정 파일: `application.properties`
- 주요 설정:
  - `notification.sse.timeout-ms`
  - `notification.pubsub.channel`
  - `notification.pubsub.listener-auto-startup`
  - `notification.stream.*`
  - `notification.popular.chunk-size`
  - `app.datasource.master.*`
  - `app.datasource.slave.*`
  - `app.datasource.route-non-transactional-to-slave`

- 토글: application.properties 파일 내용

```properties
spring.application.name=prj

#----------------------------------------------------
#?ㅽ봽留곷????꾨줈?앺듃媛 ?ъ슜???ы듃 踰덊샇,
#?몄텧??*.jsp ?뚯씪???묐몢 寃쎈줈 臾몄옄
#?몄텧??*.jsp ?뚯씪???묐? ?뚯씪?뺤옣??臾몄옄 愿???띿꽦 ?ㅼ젙?섍린
#----------------------------------------------------
server.port=8081
spring.mvc.view.prefix=/WEB-INF/views/
#spring.mvc.view.suffix=.jsp 
#----------------------------------------------------
#?ㅻ씪???쒕씪?대쾭 ?대쫫, ?ㅻ씪??URL 二쇱냼, 怨꾩젙, ?뷀샇 愿???띿꽦 ?ㅼ젙?섍린
#----------------------------------------------------
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
spring.datasource.url=jdbc:oracle:thin:@127.0.0.1:1521:xe

spring.datasource.username=king
spring.datasource.password=1234

#----------------------------------------------------------------------
# MultipartFile 媛앹껜媛 愿由ы븯???뚯씪??理쒕?  ?ш린瑜?1000MB 媛 ?ㅼ젙?섍린. ?뷀뤃?몃뒗 1MB ??
# http header ??理쒕? ?ъ씠利덈? 80KB 濡??섍린. ?뷀뤃?몃줈 8KB ??
#----------------------------------------------------------------------
spring.servlet.multipart.maxFileSize=1000MB
spring.servlet.multipart.maxRequestSize=1000MB
server.max-http-header-size=80KB

#----------------------------------------------------------------------
# mybatis ?먯꽌 ?ъ슜??SQL 援щЦ ???xml ?뚯씪???꾩튂 吏?뺥븯湲?
#----------------------------------------------------------------------
mybatis.mapper-locations=classpath*:com/wa/erp/mapper_*.xml

#----------------------------------------------------------------------
# Redis ?쒕쾭 ?ㅼ젙
#----------------------------------------------------------------------
spring.redis.host=localhost
spring.redis.port=6379
spring.redis.database=0

#----------------------------------------------------------------------
# Redis ?곌껐 ? ?ㅼ젙 (Lettuce)
#----------------------------------------------------------------------
spring.redis.lettuce.pool.max-active=8
spring.redis.lettuce.pool.max-idle=8
spring.redis.lettuce.pool.min-idle=2
spring.redis.lettuce.pool.max-wait=-1ms
spring.redis.timeout=3000ms

#----------------------------------------------------------------------
# Spring Cache ?ㅼ젙
#----------------------------------------------------------------------
spring.cache.type=redis
spring.cache.redis.cache-null-values=false
spring.cache.redis.key-prefix=erp:cache:
spring.cache.redis.use-key-prefix=true

#----------------------------------------------------------------------
# Cache Type ?ㅼ젙 (redis / caffeine / both)
# redis: Redis 罹먯떆留??ъ슜
# caffeine: 濡쒖뺄 罹먯떆留??ъ슜 (Caffeine)
# both: 2-Level Cache (Caffeine L1 -> Redis L2)
#----------------------------------------------------------------------
cache.type=redis

#----------------------------------------------------------------------
# Actuator ?ㅼ젙 (罹먯떆 硫뷀듃由?紐⑤땲?곕쭅)
#----------------------------------------------------------------------
management.endpoints.web.exposure.include=health,info,metrics,caches
management.endpoint.health.show-details=always

#----------------------------------------------------------------------
# MyBatis SQL logging (temporary for paging debug)
#----------------------------------------------------------------------
mybatis.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl

# Error details (dev only)
server.error.include-message=always
server.error.include-stacktrace=on_param

# ----------------------------------------------------------------------
# Notification (SSE + Redis Pub/Sub + Redis Stream)
# ----------------------------------------------------------------------
notification.sse.timeout-ms=3600000
notification.recent.max-size=200

notification.pubsub.channel=careerplus:notifications:pubsub
notification.pubsub.listener-auto-startup=true

notification.stream.key=careerplus:notifications:stream
notification.stream.consumer-group=careerplus-notification-group
notification.stream.consumer-name=${spring.application.name}-${random.uuid}
notification.stream.batch-size=500
notification.stream.block-seconds=2
notification.stream.poll-delay-ms=500

notification.popular.chunk-size=1000

# ----------------------------------------------------------------------
# DB Replication (Master / Slave)
# If not changed, both point to the current spring.datasource settings.
# ----------------------------------------------------------------------
app.datasource.master.driver-class-name=${spring.datasource.driver-class-name}
app.datasource.master.url=${spring.datasource.url}
app.datasource.master.username=${spring.datasource.username}
app.datasource.master.password=${spring.datasource.password}

app.datasource.slave.driver-class-name=${spring.datasource.driver-class-name}
app.datasource.slave.url=${spring.datasource.url}
app.datasource.slave.username=${spring.datasource.username}
app.datasource.slave.password=${spring.datasource.password}

# Route non-transactional read calls to slave
app.datasource.route-non-transactional-to-slave=true
```

### 메모

- `WEB_PUSH`, `EMAIL`은 현재 게이트웨이 스텁(로그 출력) 구현
- `KAKAO`, `SMS`는 미구현
- 노션에서 토글이 필요하면 각 `` 블록을 `/toggle` 블록으로 변환해 사용 가능


