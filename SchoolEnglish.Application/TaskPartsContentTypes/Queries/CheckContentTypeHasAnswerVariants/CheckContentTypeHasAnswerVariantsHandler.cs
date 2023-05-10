using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAnswerVariants
{
    public class CheckContentTypeHasAnswerVariantsHandler : IRequestHandler<CheckContentTypeHasAnswerVariantsQuery, bool>
    {
        public async Task<bool> Handle(CheckContentTypeHasAnswerVariantsQuery request, CancellationToken cancellationToken)
        {
            return BaseTaskPartContentTypesHelper.GetTypesWithAnswerVariants().Any(type => type.Id == request.TypeId);
        }
    }
}
