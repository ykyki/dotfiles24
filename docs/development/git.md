# Git 規約

Gitの使用方法, コミットメッセージ, ブランチ戦略についての規約をまとめる

## コミットメッセージ

### Subject Line (件名)
- What を記述する
- 読者がコミット一覧から内容を予測しやすいようにする
- プレフィックスを使ってコンポーネントや範囲を明示する
  - 例: `github:`, `qsite:`, `docs:`
- 英語, 日本語を問わない
- 50文字以内にする

### Body (本文)
- 必須
- Why を記述する
- なぜその変更をしたのかを説明する
- 英語, 日本語を問わない

### 例
```
github: fix run-name branch name for push events

Use github.head_ref || github.ref_name to properly display branch names
for both pull_request and push events while preserving SHA display.
```

## コミット単位

- 1つのコミットで1つの論理的変更を行う
- 論理的な変更の単位で, かつ細かい方がよい
- 関連のない変更は別のコミットに分ける
- 各コミット毎にテストやCIが通るようにする

## ブランチ戦略

- トランクベース開発を意識する
- featureブランチは使わない
- ブランチの寿命は `main` を除いて2, 3日以内に収める. 短い方がよい
- Pull Requestを使ったコードレビューを実施する
- `main` ブランチは常にデプロイ可能な状態を保つ

