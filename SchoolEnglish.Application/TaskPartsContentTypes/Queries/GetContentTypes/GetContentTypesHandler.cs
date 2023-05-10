using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.GetContentTypes
{
    public class GetContentTypesHandler : IRequestHandler<GetContentTypesQuery, TaskPartContentTypesVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetContentTypesHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<TaskPartContentTypesVm> Handle(GetContentTypesQuery request, CancellationToken cancellationToken)
        {
            var contentTypes = await _dbContext.TaskPartsContentTypes.ToListAsync();
            var mappedTypes = contentTypes.Select(type => _mapper.Map<TaskPartContentTypeDto>(type)).ToList();
            return new TaskPartContentTypesVm { ContentTypes = mappedTypes };
        }
    }
}
