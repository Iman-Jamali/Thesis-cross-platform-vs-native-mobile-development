import React, {useEffect} from 'react';
import {View, Button} from 'react-native';

const Home = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Button
        style={styles.buttonStyle}
        title="Page A"
        onPress={() => {
          console.log('start navigating to PageA:', Date.now());
          navigation.navigate('Page A');
        }}
      />
    </View>
  );
};

const styles = {
  container: {flex: 1, alignItems: 'center', justifyContent: 'center'},
  buttonStyle: {marginTop: 20},
};

export default Home;
