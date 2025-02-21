<h1>Running</h1>
<h3>Seoul Park-Based Team Recruiting, Management & Blog Web Application 🚀</h3>
🚩 <a href="https://drive.google.com/drive/u/0/folders/1JfCukVwmlw8M4BjQx7lS6PFsITp0RfIV">link</a> for Presentation PDF(written in Korean) and Recorded Preview Video </br>
<h4>3 weeks Team Project with Spring MVC Architecture </h4>
<div>Language - Java, Sql </br>
Server - Tomcat  </br>
DB - Oracle  </br>
IDE - Eclipse, SqlDeveloper  </br>
Library - jakarta.servlet-api, jakarta.servlet.jsp.jstl-api, myBatis, JUnit, Log4j, HikariCP, Jackson Data Bind, commons-fileupload, javax.mail, etc </div>


✅ Core Features
1️⃣ User Registration, Profile Update, and Deletion
-Sends an email verification link to the user's email upon registration.
-Users can select a profile image from a set of pre-provided options.
-Email address cannot be changed after registration.

2️⃣ Running Community
-General/Q&A boards: Includes view count, multiple file upload/download, post creation restricted to email-verified users, and pagination.
-Comments/Replies/Private Replies: Only email-verified users can post.
-If a comment with replies is deleted, only the content and user information are removed, while the comment remains.
-Users can view member profiles and leave or delete teams.

3️⃣ Running Team Creation/Management
-Teams can set a banner, name, title, description, activity location, gender restriction (All/Male Only/Female Only), minimum age requirement, and maximum number of members.
-When editing, the park location cannot be changed, and gender, minimum age, and member limit cannot be reduced.
-Teams can be searched by name, district, and recruitment status (Open/Closed), with pagination support.

4️⃣ Running Course Recommendations & Reviews
-Features view count, like functionality, and pagination

5️⃣ Team Community
-Team-exclusive boards: General/Album/Schedule (only the team leader can post in the schedule board, and each event has a participant number limit). Team members can post in general and album boards, with pagination.
-Real-time chat feature for team members.
-Comments/Replies: Only team members can post.
-If a comment with replies is deleted, only the content and user information are removed, while the comment remains.


✅ Additional Features
1️⃣ Current Seoul Weather 
-Retrieves daily Seoul weather data using the Free Weather API (https://www.weatherapi.com/).

2️⃣ Notification System
-Sends notifications for team join requests/approvals, comments on the user’s posts, and replies to the user’s comments.
-Differentiates between read and unread notifications.
