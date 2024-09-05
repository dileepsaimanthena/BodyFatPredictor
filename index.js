import express from 'express';
import path from 'path';
import bodyParser from 'body-parser';
import { fileURLToPath } from 'url';
import { exec } from 'child_process';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const app = express();
const port = 3000;
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});
app.get('/predict', (req, res) => {
    res.render('predict.ejs');
});
app.get('/document', (req, res) => {
    res.sendFile(path.join(__dirname, 'document.html'));
});
app.get('/contact', (req, res) => {
    res.sendFile(path.join(__dirname, 'contact.html'));
});
app.post('/submit', (req, res) => {
    const inputData = Object.values(req.body).join(' ');
    exec(`python scripts/predict_model.py ${inputData}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error executing Python script: ${error}`);
            return res.status(500).send('Error predicting body fat');
        }
        console.log(`Prediction result: ${stdout}`);
        res.render('predict.ejs', { prediction: stdout.trim() });
    });
});
app.listen(port, () => {
    console.log(`listening on port ${port}`);
});
