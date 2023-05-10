using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasTextToRead
{
    public class CheckContentTypeHasTextToReadHandler : IRequestHandler<CheckContentTypeHasTextToReadQuery, bool>
    {
        public async Task<bool> Handle(CheckContentTypeHasTextToReadQuery request, CancellationToken cancellationToken)
        {
            return BaseTaskPartContentTypesHelper.GetTypesWithTextToRead().Any(type => type.Id == request.TypeId);
        }
    }
}
