using MediatR;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasTextToRead
{
    public class CheckContentTypeHasTextToReadQuery : IRequest<bool>
    {
        public Guid TypeId { get; set; }
    }
}
