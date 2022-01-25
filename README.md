# GitlabCI Simple Notify

[![CircleCI](https://circleci.com/gh/timmilesdw/gitlabci-simple-notify/tree/main.svg?style=svg)](https://circleci.com/gh/timmilesdw/gitlabci-simple-notify/tree/main)

[![dockeri.co](https://dockeri.co/image/timmiles/gitlabci-simple-notify)](https://hub.docker.com/r/timmiles/gitlabci-simple-notify)

Simple notifications from Gitlab CI to telegram

# Usage

Set gitlab-ci variables ```TELEGRAM_BOT_TOKEN``` and ```TELEGRAM_USER_ID```

```bash
docker run timmiles/gitlabci-simple-notify <start|end> <silent | "">
```

```yaml
stages:
  - Notify Start
  - Generate Changelog
  - Build
  - Notify End

.notify_template: &notify_configuration
    image: timmiles/gitlabci-simple-notify

Notify Start:
    stage: Notify Start
    <<: *notify_configuration
    script:
      - /notify.sh start silent

Generate Changelog:
  stage: Generate Changelog
  image:
    name: quay.io/git-chglog/git-chglog:0.15.1
    entrypoint: [""]
  script:
    # Generate changelog logic

Build:
  only:
    - tags
  stage: Build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    # build logic

Notify Success:
    stage: Notify End
    <<: *notify_configuration
    script:
      - /notify.sh loud end ✅

Notify Fail:
    stage: Notify End
    <<: *notify_configuration
    script:
      - /notify.sh loud end ❌
    when: on_failure

```