const express = require("express");
const path = require("path");
const controller = require("./controller/universityController");

const app = express();
const frontendPath = path.resolve(__dirname, "../../frontend");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(frontendPath));

app.get("/api/health", controller.health);
app.get("/api/courses", controller.getCourses);
app.post("/api/courses", controller.postCourse);
app.get("/api/faculty", controller.getFaculty);
app.post("/api/faculty", controller.postFaculty);
app.get("/api/students", controller.getStudents);
app.post("/api/students", controller.postStudent);
app.get("/api/contacts", controller.getContacts);
app.post("/api/contacts", controller.postContact);
app.get("/api/reports/overview", controller.getOverview);
app.get("/api/reports/course-enrollments", controller.getCourseEnrollmentSummary);

app.get("/", (_req, res) => {
  res.sendFile(path.join(frontendPath, "index.html"));
});

app.use((error, _req, res, _next) => {
  const status = error.code === "ER_DUP_ENTRY" ? 409 : 400;

  res.status(status).json({
    success: false,
    message: error.message || "Something went wrong.",
  });
});

module.exports = app;
