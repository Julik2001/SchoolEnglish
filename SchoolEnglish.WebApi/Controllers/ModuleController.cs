using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Modules.Commands.CreateOrUpdateModule;
using SchoolEnglish.Application.Modules.Commands.DeleteModule;
using SchoolEnglish.Application.Modules.Queries;
using SchoolEnglish.Application.Modules.Queries.CheckSubmodules;
using SchoolEnglish.Application.Modules.Queries.GetModule;
using SchoolEnglish.Application.Modules.Queries.GetModules;
using SchoolEnglish.Application.Modules.Queries.GetSubmodules;
using SchoolEnglish.WebApi.Models;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class ModuleController : BaseController
    {
        private readonly IMapper _mapper;

        public ModuleController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [Authorize]
        [HttpGet("{moduleId}")]
        public async Task<ActionResult<ModuleDto>> GetModule(Guid moduleId)
        {
            var query = new GetModuleQuery { ModuleId = moduleId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<ModulesVm>> GetModules()
        {
            var query = new GetModulesQuery();
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpGet("{moduleId}")]
        public async Task<ActionResult<ModulesVm>> CheckSubmodules(Guid moduleId)
        {
            var query = new CheckSubmodulesQuery { ModuleId = moduleId };
            var hasSubmodules = await Mediator.Send(query);
            return Ok(hasSubmodules);
        }

        [Authorize]
        [HttpGet("{moduleId}")]
        public async Task<ActionResult<SubmodulesVm>> GetSubmodules(Guid moduleId)
        {
            var query = new GetSubmodulesQuery { ModuleId = moduleId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Guid>> CreateOrUpdate([FromBody] CreateOrUpdateModuleDto createOrUpdateModuleDto)
        {
            var command = _mapper.Map<CreateOrUpdateModuleCommand>(createOrUpdateModuleDto);
            var moduleId = await Mediator.Send(command);
            return Ok(moduleId);
        }

        [Authorize]
        [HttpDelete("{moduleId}")]
        public async Task<IActionResult> Delete(Guid moduleId)
        {
            var command = new DeleteModuleCommand { Id = moduleId };
            await Mediator.Send(command);
            return Ok();
        }
    }
}
