using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Common.Helpers
{
    public static class BaseTaskPartContentTypesHelper
    {
        public static TaskPartContentType RatioOfWords { get; } = new TaskPartContentType 
        { Id = Guid.Parse("8CDD0B45-ACE3-4864-9CF5-23BDBBD4E6D6"), Name = "Соотнесение слов" };
        public static TaskPartContentType RatioOfWordsAndImage { get; } = new TaskPartContentType 
        { Id = Guid.Parse("A83D524E-0474-454C-B604-9CA63674CB88"), Name = "Соотнесение слов и картинки" };
        public static TaskPartContentType ExpandBrackets { get; } = new TaskPartContentType 
        { Id = Guid.Parse("17C0AE34-B6A7-4110-B62C-F9B1D16B022F"), Name = "Раскрыть скобки" };
        public static TaskPartContentType TranslateText { get; } = new TaskPartContentType 
        { Id = Guid.Parse("4149CDDD-56B3-4CD3-83AF-377CA4722911"), Name = "Перевести текст" };
        public static TaskPartContentType ChooseOneWord { get; } = new TaskPartContentType 
        { Id = Guid.Parse("AE062AF0-AD0A-401C-8998-EBAB67F10E21"), Name = "Выбрать слово" };
        public static TaskPartContentType ArrangeWordsInCorrectOrder { get; } = new TaskPartContentType 
        { Id = Guid.Parse("DA28F7AB-8578-4BD5-A3FF-F5A879CA8FB2"), Name = "Расставить слова в правильном порядке" };
        public static TaskPartContentType RatioOfTextAndHeader { get; } = new TaskPartContentType 
        { Id = Guid.Parse("664AF0B5-648B-42F6-B319-B38947D7428C"), Name = "Соотнесение абзаца и заголовка" };
        public static TaskPartContentType ArrangeParagraphsInCorrectOrder { get; } = new TaskPartContentType 
        { Id = Guid.Parse("E05BC2BB-0E42-44E0-8A93-E25BE11E361E"), Name = "Расставить абзацы в правильном порядке" };

        public static IEnumerable<TaskPartContentType> GetBaseTypes()
        {
            return new List<TaskPartContentType> { RatioOfWords, RatioOfWordsAndImage, ExpandBrackets, TranslateText, 
                ChooseOneWord, ArrangeWordsInCorrectOrder, RatioOfTextAndHeader, ArrangeParagraphsInCorrectOrder };
        }

    }
}
