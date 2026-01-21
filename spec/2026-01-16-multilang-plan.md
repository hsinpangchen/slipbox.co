# 多語系規劃（Middleman / Slip 網站）

> 目的：以可維護、可擴充為主，讓內容與版型分離，並能產生多語版本的靜態頁面。
> 原則：中文（zh-TW）為唯一 source of truth，其他語系皆由中文翻譯而來。

## 1) 總體策略
- 使用 Middleman i18n（在 `config.rb` 啟用 `activate :i18n`）
- 內容/文案集中到 locale 檔案（YAML/JSON），頁面用 `t()` 取文案
- 每個語系產生獨立路徑（例如 `/slip/`、`/en/slip/`）
- 保留中文為 default locale，其他語系加 prefix

## 2) 檔案結構
- 新增 `locales/`（或 `data/locales/`）
  - `locales/zh-TW.yml`
  - `locales/en.yml`
- 文案 key 以區塊劃分（hero、free_plan、local_first、faq、footer、early_operators…）
- `data/social_links.json` 若需在不同語系改 label/順序，可拆為：
  - `data/social_links.zh-TW.json`
  - `data/social_links.en.json`
- 翻譯流程以 `locales/zh-TW.yml` 為準；新增/修改文案只改中文，再更新其他語系

## 3) 頁面與 partial 改造
- `source/slip/*.erb` 改用 `t("...")` 拉文案，不直接寫死文字
- `early-operators.html.erb` 改為語系資料驅動（標題/段落/清單）
- Navigation/Footer/CTA/FAQ 全部改為 i18n key
- 保留共用 partial（結構不變），只替換字串

## 4) URL 與 SEO
- Default locale（中文）維持 `/slip/`，其他語系加 prefix `/en/slip/`
- `<head>` 補 `hreflang`、canonical
- OpenGraph/Twitter metadata 也改成 i18n
- 缺翻譯時 fallback 到中文（避免出現空字串）

## 5) 語系切換
- 導覽或 footer 增加語系切換（依 `i18n.locales` 產生）
- 允許保持當前路徑切換語系（同頁對應）

## 6) 風險與注意事項
- 圖片若含文字需替換（或改成無文字版本）
- CTA 連結若區域不同（App Store 國別）需 per-locale 設定
- 文案長度差異會影響版面，需要補 CSS 調整

## 7) 需要確認的決策
1) 語系清單（例如 `zh-TW`, `en`, `ja`）
2) URL 策略（預設語系是否要 prefix？例如 `/slip/` vs `/zh-TW/slip/`）
3) 翻譯更新流程（手動/外包/內部）

## 8) 已確認決策（2026-01-16）
- 目標語系：`zh-TW`（source of truth）、`en`、`ja`
- 使用 Cloudflare Pages + Workers（Pages Functions）做語系自動切換
