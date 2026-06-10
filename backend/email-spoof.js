const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  host: 'smtp.example.com', // Use real or spoof
  port: 587,
  secure: false,
  auth: { user: 'ghost@craft.com', pass: 'adminpass' }
});

async function sendFakeReceipt(to, bank, amount) {
  await transporter.sendMail({
    from: 'no-reply@ghostcraft.net',
    to,
    subject: `${bank} Transaction Receipt`,
    html: `<h1>GhostCraft Fake Slip</h1><p>Amount: ${amount}</p>`
  });
}

module.exports = { sendFakeReceipt };
