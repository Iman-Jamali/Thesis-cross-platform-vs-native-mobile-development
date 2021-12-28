import React, {useState, useEffect} from 'react';
import {View, Text, FlatList, TouchableOpacity} from 'react-native';
import {getTodos} from '../todoApi';

const TodoList = ({navigation}) => {
  const [data, setData] = useState([]);

  useEffect(() => {
    const unsubscribe = navigation.addListener('focus', async () => {
      const todos = await getTodos();
      setData(todos);
    });
    return unsubscribe;
  }, [navigation]);

  const handleItemClicked = id => {
    navigation.navigate('EditTodoPage', {todoId: id});
  };

  const handleAddTodo = () => {
    navigation.navigate('EditTodoPage');
  };

  const renderItem = ({item}) => (
    <TouchableOpacity
      style={styles.itemContainer}
      onPress={() => handleItemClicked(item.id)}>
      <Text style={styles.title}>{item.title}</Text>
      <Text style={styles.date}>{item.updatedAt}</Text>
      <Text style={styles.description}>{item.description}</Text>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <FlatList
        data={data}
        renderItem={renderItem}
        keyExtractor={item => item.id}
        ItemSeparatorComponent={() => (
          <View
            style={{
              height: 1,
              width: '100%',
              backgroundColor: 'rgb(230, 230, 230)',
            }}
          />
        )}
      />
      <TouchableOpacity style={styles.fab} onPress={handleAddTodo}>
        <Text style={{fontSize: 24, color: '#0980ff'}}>Add</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = {
  container: {flex: 1, backgroundColor: '#fff'},
  itemContainer: {padding: 16},
  title: {fontSize: 20, fontWeight: 'bold', paddingTop: 8, paddingBottom: 8},
  date: {fontSize: 14, paddingTop: 4, paddingBottom: 10},
  description: {fontSize: 18, paddingTop: 4, paddingBottom: 10},
  fab: {
    position: 'absolute',
    bottom: 32,
    right: 32,
  },
};

export default TodoList;
