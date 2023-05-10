using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Tasks.Commands.CreateOrUpdateTask;
using SchoolEnglish.Application.Tasks.Commands.DeleteTask;
using SchoolEnglish.Application.Tasks.Queries.GetTask;
using SchoolEnglish.Application.Tasks.Queries.GetTasksInModule;
using SchoolEnglish.WebApi.Models;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class TaskController : BaseController
    {
        private readonly IMapper _mapper;

        public TaskController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [Authorize]
        [HttpGet("{taskId}")]
        public async Task<ActionResult<TaskVm>> GetTask(Guid taskId)
        {
            var query = new GetTaskQuery { Id = taskId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpGet("{moduleId}")]
        public async Task<ActionResult<ModuleTasksVm>> GetTasksInModule(Guid moduleId)
        {
            var query = new GetTasksInModuleQuery { ModuleId = moduleId };
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Guid>> CreateOrUpdate([FromBody] CreateOrUpdateTaskDto createOrUpdateTaskDto)
        {
            var command = _mapper.Map<CreateOrUpdateTaskCommand>(createOrUpdateTaskDto);
            var taskId = await Mediator.Send(command);
            return Ok(taskId);
        }

        [Authorize]
        [HttpDelete("{taskId}")]
        public async Task<IActionResult> Delete(Guid taskId)
        {
            var command = new DeleteTaskCommand { Id = taskId };
            await Mediator.Send(command);
            return Ok();
        }
    }
}
