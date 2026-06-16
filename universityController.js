const app = require("./app");
const { getConfig } = require("./config/properties");

const {
  server: { port },
} = getConfig();

app.listen(port, () => {
  console.log(`StudentAssist server is running on http://localhost:${port}`);
});
