namespace SchoolEnglish.Application.Reports.Queries.GetReportForTeacher
{
    public class TeacherReportVm
    {
        public int TasksCompleted { get; set; }
        public double CorrectAnswersPercentage { get; set; }
        public int AverageGrade { get; set; }
    }
}
