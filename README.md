# 初回の構成手順

## プロジェクトの生成

```
docker compose build --no-cache
```

```
docker compose run --rm backend django-admin startproject config .
```

## 言語とタイムゾーンの修正

`backend/config/settings.py`を以下のように修正する。

```
LANGUAGE_CODE = 'ja'
TIME_ZONE = 'Asia/Tokyo'

```

## 環境変数読み込み設定

- .env.example をコピーして.env を作り、DB_NAME、DB_USER、DB_PASS、DB_HOST を設定。

- `backend/config/settings.py`に以下の記述を追加。

```
import os
```

## データベース接続設定の修正

`backend/config/settings.py`を以下のように変更。

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

↓↓↓↓↓↓↓↓↓↓↓↓

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.getenv('DB_NAME'),
        'USER': os.getenv('DB_USER'),
        'PASSWORD': os.getenv('DB_PASS'),
        'HOST': os.getenv('DB_HOST'),
        'PORT': 3306,
    }
}
```

## フロントのプロジェクト作成

```
make create-next-app
```

## コンテナ立ち上げ

```
docker compose up -d
```

## データベースのセットアップ

```
docker compose exec backend python3 manage.py migrate
```

## アクセスして動作確認

ブラウザから localhost:8000 にアクセスする

## app と accounts のアプリケーションを作成

app を作成

```
docker compose exec backend python3 manage.py startapp app
```

accounts を作成

```
docker compose exec backend python3 manage.py startapp accounts
```

## 設定変更

`backend/config/settings.py` の INSTALLED_APPS に以下を追加する。

```
'rest_framework',
'app',
'accounts',
```

### rest_framework と JWT の設定

`backend/config/settings.py`に以下を追加する

```
REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],
}

SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(hours=1),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=3),
    'ROTATE_REFRESH_TOKENS': False,
    'AUTH_HEADER_TYPES': ('Bearer',),
    'AUTH_TOKEN_CLASSES': ('rest_framework_simplejwt.tokens.AccessToken',),
}
```

# クローン時の処理

## 参考

https://katakata-gym.com/blog/peHLIhqiGBfkxcWhNX6b
https://self-methods.com/django-docker-easy/
https://docs.docker.jp/compose/django.html
https://qiita.com/Aruneko/items/971e65a945d23f7bb8b6

https://t-keita.hatenadiary.jp/entry/2021/03/24/020619

# 管理アカウント

aa@aa.com
shott
qwert124
