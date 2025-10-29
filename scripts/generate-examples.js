const fs = require('fs');
const path = require('path');

const templatesDir = path.join(__dirname, '../templates');
const examplesDir = path.join(__dirname, '../examples');

if (!fs.existsSync(examplesDir)) fs.mkdirSync(examplesDir, { recursive: true });

fs.readdirSync(templatesDir).forEach(file => {
  if (file.endsWith('.md')) {
    const base = path.basename(file, '.md');
    const exampleFile = path.join(examplesDir, `${base}-example.md`);
    if (!fs.existsSync(exampleFile)) {
      const content = `# Example: ${base}\n\nThis is an auto-generated example file based on **${file}**.\n\n> Customize this with your real-world scenario.\n`;
      fs.writeFileSync(exampleFile, content, 'utf8');
    }
  }
});
