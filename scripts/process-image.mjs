import sharp from 'sharp';
import fs from 'node:fs';
import path from 'node:path';

export async function processImage(srcPath, destBaseName, targetDir, width = 600, height = 600) {
  if (!fs.existsSync(srcPath)) {
    throw new Error(`Source file not found: ${srcPath}`);
  }
  if (!fs.existsSync(targetDir)) {
    fs.mkdirSync(targetDir, { recursive: true });
  }

  const jpgDest = path.join(targetDir, `${destBaseName}.jpg`);
  const webpDest = path.join(targetDir, `${destBaseName}.webp`);

  fs.copyFileSync(srcPath, jpgDest);

  await sharp(srcPath)
    .resize(width, height, { fit: 'cover' })
    .webp({ quality: 85 })
    .toFile(webpDest);

  console.log(`Processed: ${destBaseName} -> ${webpDest}`);
}

// When called directly
if (process.argv[2] && process.argv[3] && process.argv[4]) {
  const [,, src, name, destDir, w, h] = process.argv;
  processImage(src, name, destDir, w ? parseInt(w) : 600, h ? parseInt(h) : 600)
    .then(() => console.log('Done!'))
    .catch(err => {
      console.error(err);
      process.exit(1);
    });
}

