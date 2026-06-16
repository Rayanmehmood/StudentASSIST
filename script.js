<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <link href="style.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Rubik+Vinyl&display=swap" rel="stylesheet">
</head>
<body data-page="faq">
    <nav class="navbar">
        <a class="logo" href="index.html">studentassist</a>
        <div class="links">
            <a href="index.html">Home</a>
            <a href="about.html">About</a>
            <a href="faculty.html">Faculty</a>
            <a href="courses.html">Courses</a>
            <a href="faq.html">FAQ</a>
        </div>
        <a class="view-course" href="about.html">Contact Us</a>
    </nav>

    <section class="page-banner">
        <h1>Frequently Asked Questions</h1>
        <p>Common questions about the new full-stack StudentAssist project.</p>
    </section>

    <main class="page-shell">
        <section class="section">
            <div class="section-heading">
                <h2>Project Questions</h2>
                <p>The FAQ section keeps your original accordion interaction and explains the new backend setup.</p>
            </div>
            <div class="faq-container">
                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>What database does this project use now?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>The project now uses MySQL with tables for students, courses, faculty, and contact messages.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>Which backend technology is connected to the frontend?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>The frontend is connected to a Node.js and Express backend that serves API routes and the static frontend pages.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>Does the SQL file include constraints and triggers?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>Yes. The SQL script includes primary keys, foreign keys, unique constraints, check constraints, stored procedures, triggers, and views.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>How are students linked to courses?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>The `student.course_id` field is a foreign key that references the `course.id` column.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>Can I create new records from the website now?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>Yes. Students, courses, faculty members, and contact messages can all be added from the frontend forms.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-title" onclick="toggleFaq(this)">
                        <span>Where should I configure my MySQL credentials?</span>
                        <span class="arrow">&#9654;</span>
                    </div>
                    <div class="faq-content">
                        <p>Set your database details in the backend `application.properties` file before starting the server.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <h3>Explore, Learn &amp; Innovate</h3>
        <div class="right">
            <div class="links">
                <a href="about.html">About</a>
                <a href="courses.html">Courses</a>
                <a href="faculty.html">Faculty</a>
                <a href="faq.html">FAQ</a>
            </div>
            <p>Copyright © 2026 StudentAssist. All Rights Reserved.</p>
        </div>
    </footer>
    <script src="script.js"></script>
</body>
</html>
