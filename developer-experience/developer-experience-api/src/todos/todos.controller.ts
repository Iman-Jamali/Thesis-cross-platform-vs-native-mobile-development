import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { CreateTodoDTO } from './dto/create-todo.dto';
import { UpdateTodoDTO } from './dto/update-todo.dto';
import { Todo } from './entities/todo.entity';
import { TodosService } from './todos.service';

@Controller('todos')
export class TodosController {
  constructor(private todosService: TodosService) {}

  @Post()
  @UsePipes(ValidationPipe)
  async create(@Body() createTodoDTO: CreateTodoDTO): Promise<void> {
    return this.todosService.create(createTodoDTO);
  }

  @Get()
  getAll(): Promise<Todo[]> {
    return this.todosService.findAll();
  }

  @Get('/:id')
  getById(@Param('id', new ParseUUIDPipe()) id: string): Promise<Todo> {
    return this.todosService.findById(id);
  }

  @Patch('/:id')
  @UsePipes(ValidationPipe)
  update(
    @Param('id', new ParseUUIDPipe()) id: string,
    @Body() updateTodoDTO: UpdateTodoDTO,
  ): Promise<Todo> {
    return this.todosService.update(id, updateTodoDTO);
  }

  @Delete('/:id')
  deleteTask(@Param('id', new ParseUUIDPipe()) id: string): Promise<void> {
    return this.todosService.delete(id);
  }
}
