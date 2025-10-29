const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const pandoc = require('pandoc-bin');

const generateHtml = (inputDir, outputDir) => {
  if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });
  fs.readdirSync(inputDir).forEach(file => {
    if (file.endsWith('.md')) {
      const base = path.basename(file, '.md');
      const inputPath = path.join(inputDir, file);
      const outputPath = path.join(outputDir, `${base}.html`);
      execSync(`"${pandoc}" "${inputPath}" -s -o "${outputPath}" --metadata title="${base}"`);
    }
  });
};

generateHtml(path.join(__dirname, '../templates'), path.join(__dirname, '../docs/templates'));
generateHtml(path.join(__dirname, '../examples'), path.join(__dirname, '../docs/examples'));
