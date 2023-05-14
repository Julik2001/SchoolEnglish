using MediatR;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeTextIsMultiline
{
    public class CheckContentTypeTextIsMultilineQuery : IRequest<bool>
    {
        public Guid TypeId { get; set; }
    }
}
