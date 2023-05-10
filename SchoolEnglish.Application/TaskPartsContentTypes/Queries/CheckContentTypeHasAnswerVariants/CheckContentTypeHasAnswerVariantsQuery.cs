using MediatR;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAnswerVariants
{
    public class CheckContentTypeHasAnswerVariantsQuery : IRequest<bool>
    {
        public Guid TypeId { get; set; }
    }
}
