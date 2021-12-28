import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
} from '@nestjs/common';

const todo = {
  id: '1',
  title: 'Todo One',
  description: 'Todo one description',
};

@Controller('todos')
export class TodosController {
  @Get('/:id')
  getTodo(@Param('id') id: string): any {
    console.log('get', id);
    return todo;
  }

  @Post()
  createTodo(@Body() todo): any {
    console.log('post', todo);
    return { message: 'Todo created' };
  }

  @Patch('/:id')
  updateTodo(@Body() todo, @Param('id') id: string): any {
    console.log('path', id, todo);
    return { id };
  }

  @Delete('/:id')
  deleteTodo(@Param('id') id: string): any {
    console.log('delete', id);
    return { id };
  }
}
