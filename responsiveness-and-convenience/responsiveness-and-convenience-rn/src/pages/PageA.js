import React, {useEffect} from 'react';
import {Text, View} from 'react-native';

const PageA = () => {
  useEffect(() => {
    console.log('after navigating to PageA:', Date.now());
  }, []);

  return (
    <View style={styles.container}>
      <Text>Page A</Text>
    </View>
  );
};

const styles = {
  container: {flex: 1, alignItems: 'center', justifyContent: 'center'},
};

export default PageA;
