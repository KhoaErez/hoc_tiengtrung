const { GoogleGenAI } = require('@google/genai');

async function test() {
  require('dotenv').config({ path: '.env.local' });
  const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });
  
  try {
    const models = [
      'gemini-3.1-pro-preview',
      'gemini-3.8-pro',
      'gemini-3.5-flash',
      'gemini-4.0-flash'
    ];
    
    for (const model of models) {
      console.log('Testing ' + model + '...');
      try {
        const response = await ai.models.generateContent({
          model: model,
          contents: 'say hi',
        });
        console.log('SUCCESS with ' + model);
        return;
      } catch (e) {
        console.log('FAILED ' + model + ':', e.message);
      }
    }
  } catch (e) {
    console.log('Fatal Error:', e.message);
  }
}
test();
