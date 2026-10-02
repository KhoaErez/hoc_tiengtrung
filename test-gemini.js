const { GoogleGenAI } = require('@google/genai');

async function test() {
  require('dotenv').config({ path: '.env.local' });
  const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY });
  
  try {
    const models = [
      'gemini-3.8-flash',
      'gemini-1.5-flash',
      'gemini-1.5-pro',
      'gemini-2.0-flash',
      'gemini-2.5-pro'
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
