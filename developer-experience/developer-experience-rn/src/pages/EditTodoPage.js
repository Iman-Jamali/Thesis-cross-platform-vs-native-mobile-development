import React, {useState, useEffect} from 'react';
import {View, Text, Button, TextInput} from 'react-native';
import {getTodo, addTodo, updateTodo, deleteTodo} from '../todoApi';

const EditTodo = ({route, navigation}) => {
  const [title, setTitle] = useState({value: '', touched: false});
  const [description, setDescription] = useState({value: '', touched: false});
  const [isEdit, setIsEdit] = useState(false);
  const todoId = route?.params?.todoId;

  useEffect(() => {
    setIsEdit(Boolean(todoId));
  }, [todoId]);

  useEffect(() => {
    if (isEdit) {
      navigation.setOptions({title: 'Edit Todo'});
      (async () => {
        const todo = await getTodo(todoId);
        setTitle({value: todo.title, touched: false});
        setDescription({value: todo.description, touched: false});
      })();
    }
  }, [todoId, isEdit]);

  const handleChange = (value, name) => {
    if (name === 'title') {
      setTitle({value, touched: true});
    } else if (name === 'description') {
      setDescription({value, touched: true});
    }
  };

  const handleSubmit = async event => {
    if (!title.value || !description.value) {
      setTitle({...title, touched: true});
      setDescription({...description, touched: true});
      return;
    }
    const todoItem = {
      title: title.value,
      description: description.value,
    };
    try {
      if (isEdit) {
        await updateTodo(todoItem, todoId);
      } else {
        await addTodo(todoItem);
      }
      handleGoBack();
    } catch (error) {
      alert(error);
    }
  };

  const handleGoBack = () => {
    navigation.goBack();
  };

  const handleDelete = async () => {
    await deleteTodo(todoId);
    handleGoBack();
  };

  return (
    <View style={styles.container}>
      <View style={styles.form}>
        <View>
          <TextInput
            placeholder="Title"
            style={styles.textInput}
            value={title.value}
            onChangeText={value => handleChange(value, 'title')}
          />
          {title.value === '' && title.touched && (
            <Text style={styles.errorText}>Title is required</Text>
          )}
        </View>
        <View style={{paddingTop: 16}}>
          <TextInput
            placeholder="Description"
            style={styles.textInput}
            value={description.value}
            onChangeText={value => handleChange(value, 'description')}
          />
          {description.value === '' && description.touched && (
            <Text style={styles.errorText}>Description is required</Text>
          )}
        </View>
        <View style={styles.formAction}>
          <Button title="Cancel" onPress={handleGoBack} />
          {isEdit && (
            <Button title="Delete" onPress={handleDelete} color="red" />
          )}
          <Button title={isEdit ? 'Update' : 'Add'} onPress={handleSubmit} />
        </View>
      </View>
    </View>
  );
};

const styles = {
  container: {
    flex: 1,
    alignItems: 'center',
    padding: 16,
    backgroundColor: 'white',
  },
  form: {
    width: '100%',
  },
  textInput: {
    borderWidth: 1,
    borderColor: 'gray',
    padding: 16,
    borderRadius: 4,
  },
  errorText: {
    color: 'red',
    fontSize: 12,
  },
  formAction: {
    paddingTop: 32,
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
};

export default EditTodo;
