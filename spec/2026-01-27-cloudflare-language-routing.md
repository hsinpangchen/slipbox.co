# Cloudflare 依語言導向（GitHub Pages）規格

## 目標
- 在 GitHub Pages 的靜態站前面加上 Cloudflare 導向。
- 讓 `/` 與 `/slip` 依瀏覽器語言導向至 `/en/` 或 `/zh-TW/`（或其他語言）。

## 前置條件
- 網域 DNS 已改由 Cloudflare 代管。
- DNS 記錄需開啟 Proxy（橘雲），Worker 才會生效。
- 站點本身已產出對應語系的靜態路徑，例如 `/en/slip/`、`/zh-TW/slip/`。

## 流程選項
### A. 固定導向（不判斷語言）
1) 在 Cloudflare 建立 Redirect Rule。
2) 規則：當路徑為 `/` 或 `/slip` 時，導向指定語系（例如 `/en/` 或 `/en/slip/`）。
3) 適用於不需要語言判斷的情境。

### B. 依語言導向（推薦）
1) 建立 Cloudflare Worker。
2) Worker 讀取 `Accept-Language`，決定目標語系。
3) 設定 Worker Route（例如 `example.com/*`）。

## Worker 範例（/ 與 /slip）
```js
export default {
  async fetch(request) {
    const url = new URL(request.url);
    const pathname = url.pathname;

    // 只處理 / 與 /slip
    if (pathname === '/' || pathname === '/slip' || pathname === '/slip/') {
      const lang = (request.headers.get('Accept-Language') || '').toLowerCase();
      const isZh = lang.startsWith('zh');
      const locale = isZh ? 'zh-TW' : 'en';

      const suffix = pathname.startsWith('/slip') ? '/slip/' : '/';
      return Response.redirect(`/${locale}${suffix}`, 302);
    }

    return fetch(request);
  }
}
```

## DNS 建議（GitHub Pages）
- `www`：CNAME 指向 `username.github.io`
- apex（根網域）：
  - 使用 A/AAAA 指向 GitHub Pages 的 IP，或
  - 使用 Cloudflare 的 CNAME flattening

## 注意事項
- Worker 只在 Cloudflare Proxy（橘雲）流量上執行。
- 導向只解決「入口路由」，多語內容仍必須由靜態輸出產生。
- 若要支援更多語言（如 `ja`），只需擴充 `locale` 判斷與對應目標路徑。
