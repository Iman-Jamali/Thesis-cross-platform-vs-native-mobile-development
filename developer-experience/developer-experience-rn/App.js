import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import TodoListPage from './src/pages/TodoListPage';
import EditTodoPage from './src/pages/EditTodoPage';

const Stack = createNativeStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          options={{title: 'Todo List'}}
          name="TodoListPage"
          component={TodoListPage}
        />
        <Stack.Screen
          options={{title: 'Add Todo'}}
          name="EditTodoPage"
          component={EditTodoPage}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
