<!-- DRAFT: pending native review before publication. -->
# AI Engineering Playbook

コードエージェントと一緒に、エンジニアリングの規律を捨てずにソフトウェアを作る方法です。

プロンプト集ではありません。エージェントの周りにある仕組みです。契約、ゲート付きの計画、テストによる安全網、diff の人によるレビュー、そして「エージェントはいつか間違える」という前提の秘密情報管理です。

[English](README.md) · [Español](README.es.md) · [Português](README.pt.md)

---

## 課題

コードエージェントは速く、自信があります。その組み合わせは、本番環境、個人データ、認証情報、クライアントコードを扱うときに危険です。

想定する失敗:

- アプリを起動しただけで「テストが通った」と言う;
- 実装の途中で計画のスコープが変わる;
- 秘密情報が commit、fixture、screenshot に入る;
- 「小さな refactor」が公開インターフェースを書き換える;
- diff が大きすぎて誰もレビューしない;
- コンテキストが失われ、次のセッションで同じ間違いを繰り返す。

## 方法

### 1. 契約: `AGENTS.md`

リポジトリに、エージェント向けの契約を書きます。ミッション、情報源（source of truth）、不変条件、禁止事項、検証要件、完了条件です。読める長さで、守れる具体性にします。

Template: [`templates/AGENTS.md`](templates/AGENTS.md)

### 2. ゲート付きの計画

作業をフェーズに分けます。各フェーズに目的、レポート、証拠、ゲートがあります。ゲートを満たせない場合は止まって質問します。勝手に進めません。

Template: [`docs/PLAN-TEMPLATE.md`](docs/PLAN-TEMPLATE.md)

### 3. テストを安全網にする

アプリを起動しただけでは合格ではありません。プロダクトがそうするなら、import、edit、save、reopen、render まで確認します。ハードウェア依存の確認は明記し、本当にハードウェアがない場合だけ skip します。

Guide: [`docs/TESTING-WITH-AGENTS.md`](docs/TESTING-WITH-AGENTS.md)

### 4. diff の人によるレビュー

エージェントが提案し、人が受け入れます。レビューでは scope creep、静かな interface 変更、削除されたテスト、新しい依存、秘密情報、PII、誤解を招く docs を確認します。

Checklist: [`docs/REVIEW-CHECKLIST.md`](docs/REVIEW-CHECKLIST.md)

### 5. 秘密情報の管理

秘密情報はいつかどこかに貼られると仮定します。リポジトリに届かないように設計します。

- working tree だけでなく、追跡ファイルをスキャンする;
- hidden files と tracked-but-ignored files もスキャンする;
- 公開用の commit identity を設定する;
- 公開リリースでは新しい Git 履歴を使う;
- fail closed の pre-push check を置く;
- 露出したものは rotate する。

Guide: [`docs/SECRET-HYGIENE.md`](docs/SECRET-HYGIENE.md)  
Script: [`scripts/check-no-secrets.sh`](scripts/check-no-secrets.sh)

### 6. MCP とローカルツール

MCP サーバーは強力で、権限を広げすぎやすいです。localhost に bind し、token を限定し、tool call を記録し、commit されうる config に token を置きません。

Guide: [`docs/MCP-SETUP.md`](docs/MCP-SETUP.md)

---

## このリポジトリの内容

```text
templates/AGENTS.md          repository の契約テンプレート
docs/PLAN-TEMPLATE.md        ゲートと証拠を含むフェーズ計画
docs/REVIEW-CHECKLIST.md     人によるレビュー checklist
docs/TESTING-WITH-AGENTS.md  エージェントが書いたコードのテスト戦略
docs/MCP-SETUP.md            ローカル MCP の設定と権限
docs/SECRET-HYGIENE.md       スキャン、commit identity、インシデント対応
scripts/check-no-secrets.sh  依存なしの小さなスキャナ
```

## これは何ではないか

- 魔法のプロンプト集ではありません。
- エージェントがレビューを代替するという主張ではありません。
- スキャンがすべての秘密情報を見つける保証はありません。
- 特定ベンダーに依存しません。例は汎用的なツールです。

## 対象

本番環境、個人データ、クライアントコードを扱う実際のリポジトリで、コードエージェントを使うエンジニア。

## ライセンス

CC BY 4.0。詳細は [`LICENSE`](LICENSE) を参照してください。
