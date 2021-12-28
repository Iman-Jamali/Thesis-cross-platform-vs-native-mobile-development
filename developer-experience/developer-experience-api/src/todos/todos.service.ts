import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateTodoDTO } from './dto/create-todo.dto';
import { UpdateTodoDTO } from './dto/update-todo.dto';
import { Todo } from './entities/todo.entity';

@Injectable()
export class TodosService {
  constructor(
    @InjectRepository(Todo) private todosRepository: Repository<Todo>,
  ) {}

  async create(createTodoDTO: CreateTodoDTO): Promise<void> {
    const { title, description } = createTodoDTO;
    const todo = new Todo();
    todo.title = title;
    todo.description = description;
    try {
      await todo.save();
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  async findAll(): Promise<Todo[]> {
    try {
      const todos = await this.todosRepository.find();
      return todos;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  async findById(id: string): Promise<Todo> {
    try {
      const todo = await this.todosRepository.findOneOrFail({
        where: { id },
      });
      return todo;
    } catch (error) {
      console.log(error);
      throw new NotFoundException(`Todo not found!`);
    }
  }

  async update(id: string, newTodo: UpdateTodoDTO): Promise<Todo> {
    const { title, description } = newTodo;
    const todo = await this.findById(id);
    todo.title = title;
    todo.description = description;
    try {
      return await todo.save();
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  async delete(id: string): Promise<void> {
    try {
      const result = await this.todosRepository.delete({
        id,
      });
      if (result.affected === 0) {
        throw new NotFoundException(`Todo not found!`);
      }
    } catch (error) {
      console.log(error);
      // throw new NotFoundException(`Todo not found!`);
      throw error;
    }
  }
}
