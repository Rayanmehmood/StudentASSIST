const repository = require("../repository/universityRepository");
const {
  normalizeStudent,
  normalizeCourse,
  normalizeFaculty,
  normalizeContact,
} = require("../model/universityModel");

async function listCourses() {
  return repository.getCourses();
}

async function addCourse(payload) {
  return repository.createCourse(normalizeCourse(payload));
}

async function listFaculty() {
  return repository.getFaculty();
}

async function addFaculty(payload) {
  return repository.createFaculty(normalizeFaculty(payload));
}

async function listStudents() {
  return repository.getStudents();
}

async function addStudent(payload) {
  return repository.createStudent(normalizeStudent(payload));
}

async function listContacts() {
  return repository.getContacts();
}

async function addContact(payload) {
  return repository.createContact(normalizeContact(payload));
}

async function getOverview() {
  return repository.getOverview();
}

async function getCourseEnrollmentSummary() {
  return repository.getCourseEnrollmentSummary();
}

module.exports = {
  listCourses,
  addCourse,
  listFaculty,
  addFaculty,
  listStudents,
  addStudent,
  listContacts,
  addContact,
  getOverview,
  getCourseEnrollmentSummary,
};
