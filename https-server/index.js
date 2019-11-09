const fs = require('fs');
const https = require('https');

const HTTPS_PORT = 443;

const currentTime = () => {
    const date = new Date();
    const h = date.getHours();
    const m = date.getMinutes();
    const s = date.getSeconds();
    const ms = date.getMilliseconds();
    return `${h}:${m}:${s}.${ms}`;
};

const log = text => {
    console.info(`[${currentTime()}] ------------- ${text} -------------`);
};

const httpsServer = https.createServer({
    key: fs.readFileSync(`${process.env.server_key_dir}/server-key.pem`),
    cert: fs.readFileSync(`${process.env.server_key_dir}/server.crt`),
});

httpsServer.on('request', (req, res) => {
    log(`[${req.method}] ${req.url}, host: ${req.headers.host}`);
    res.writeHead(200);
    res.write('<title>hello</title>\n');
    res.end('hello world\n');
});

httpsServer.on('error', err => {
    log(`HTTPS Server error: ${err.message}`);
    console.error(err);
});

httpsServer.listen(HTTPS_PORT, '0.0.0.0', () => {
    log(`server started (https://${process.env.HTTPS_SERVER_BIND_IP}/)`);
});
