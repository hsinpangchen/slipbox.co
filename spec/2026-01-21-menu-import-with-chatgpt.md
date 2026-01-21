# menu-import-with-chatgpt

## Purpose

Provide a simple instructional web page that teaches Slip users how to use ChatGPT
to convert a menu image into a structured `menu.json`, which can then be imported
into the Slip POS app.

This page is **instructional only**.
Slip does NOT perform OCR or AI inference on this page.

Target users:
- Early adopters
- Power users
- Restaurant owners comfortable following step-by-step instructions

---

## Page URL

/menu-import-with-chatgpt

---

## Design Principles

- Extremely simple
- Step-by-step
- No AI theory explanation
- No marketing language
- No account or login
- Optimized for mobile viewing
- Copy-first (users will copy prompt text)

Tone:
- Calm
- Neutral
- Practical
- Slightly cautionary (AI-generated content)

---

## Page Structure

### 1. Page Header

**Title**  
使用 AI 快速匯入菜單（約 3 分鐘）

**Subtitle**  
透過 ChatGPT 將菜單圖片轉換為 JSON，再匯入 Slip。

---

### 2. Overview Section

Slip 本身不會自動辨識菜單圖片。  
此流程會引導你使用 ChatGPT，將菜單圖片轉換成 Slip 可匯入的 JSON 格式。

適合：
- 已有紙本或圖片菜單
- 想快速建立菜單資料的使用者

---

### 3. Step-by-Step Instructions

#### Step 1 — Open ChatGPT

請打開 ChatGPT（手機或電腦皆可）。

---

#### Step 2 — Upload Your Menu Image

- 拍攝紙本菜單  
- 或上傳既有圖片  
- 清楚可讀即可，不需裁切完美

---

#### Step 3 — Copy & Paste the Prompt

請將下方指令完整複製，貼到 ChatGPT 對話中。

```
請將這張菜單圖片轉換為 JSON。
請只輸出 JSON，不要任何說明文字。

JSON 格式如下：
{
  "sections": [
    {
      "name": "分類名稱",
      "items": [
        {
          "name": "品項名稱",
          "price": 0
        }
      ]
    }
  ]
}

規則：
- 價格請轉為整數
- 若菜單沒有分類，請放入「未分類」
- 不確定的內容請合理推測
- 請確保輸出為合法 JSON
```

---

#### Step 4 — Get `menu.json`

ChatGPT 回傳後，請確認內容為 JSON 格式，
並完整複製（從 `{` 開始，到 `}` 結束）。

---

#### Step 5 — Import into Slip

回到 Slip → 菜單匯入 → 貼上 JSON → 預覽 → 匯入。

---

### 4. Important Notes

- 此內容由 AI 產生，可能需要人工確認
- 匯入前 Slip 會提供預覽畫面
- 價格與分類請自行確認是否正確

---

### 5. Responsibility Disclaimer

此流程僅提供操作指引。  
ChatGPT 的辨識結果由使用者自行確認與負責。
