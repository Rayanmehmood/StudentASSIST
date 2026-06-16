const service = require("../service/universityService");

function asyncHandler(handler) {
  return async (req, res, next) => {
    try {
      await handler(req, res);
    } catch (error) {
      next(error);
    }
  };
}

const health = asyncHandler(async (_req, res) => {
  res.json({
    success: true,
    message: "StudentAssist backend is running.",
  });
});

const getCourses = asyncHandler(async (_req, res) => {
  res.json(await service.listCourses());
});

const postCourse = asyncHandler(async (req, res) => {
  res.status(201).json(await service.addCourse(req.body));
});

const getFaculty = asyncHandler(async (_req, res) => {
  res.json(await service.listFaculty());
});

const postFaculty = asyncHandler(async (req, res) => {
  res.status(201).json(await service.addFaculty(req.body));
});

const getStudents = asyncHandler(async (_req, res) => {
  res.json(await service.listStudents());
});

const postStudent = asyncHandler(async (req, res) => {
  res.status(201).json(await service.addStudent(req.body));
});

const getContacts = asyncHandler(async (_req, res) => {
  res.json(await service.listContacts());
});

const postContact = asyncHandler(async (req, res) => {
  res.status(201).json(await service.addContact(req.body));
});

const getOverview = asyncHandler(async (_req, res) => {
  res.json(await service.getOverview());
});

const getCourseEnrollmentSummary = asyncHandler(async (_req, res) => {
  res.json(await service.getCourseEnrollmentSummary());
});

module.exports = {
  health,
  getCourses,
  postCourse,
  getFaculty,
  postFaculty,
  getStudents,
  postStudent,
  getContacts,
  postContact,
  getOverview,
  getCourseEnrollmentSummary,
};
