import OpenAI from 'openai'
import dotenv from 'dotenv'
import fs from 'fs'

dotenv.config({ path: '.env.local' })

async function test() {
  const apiKey = process.env.KIE_API_KEY || process.env.GEMINI_API_KEY;
  const baseURL = process.env.KIE_BASE_URL || "https://api.kie.ai/v1";
  const model = process.env.KIE_MODEL || 'google/gemini-1.5-flash';

  console.log("-----------------------------------------");
  console.log("API Key found:", apiKey ? `Yes (length: ${apiKey.length})` : "No");
  console.log("Base URL:", baseURL);
  console.log("Model:", model);
  console.log("-----------------------------------------");

  if (!apiKey) {
    console.log("❌ ERROR: Missing API Key in .env.local");
    return;
  }

  const ai = new OpenAI({ 
    apiKey,
    baseURL
  })

  try {
    console.log(`Sending request to ${baseURL} ...`);
    const response = await ai.chat.completions.create({
      model: model,
      messages: [{ role: "user", content: "Say 'Hello, API works!'" }]
    });
    console.log("✅ SUCCESS!");
    console.log("Response:", response.choices[0].message.content);
  } catch (error) {
    console.log("❌ ERROR FAILED!");
    console.log(error.message);
    if (error.response) {
      console.log("Status:", error.response.status);
      console.log("Data:", error.response.data);
    }
  }
}

test();
