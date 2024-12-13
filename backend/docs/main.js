const SwaggerParser = require('@apidevtools/swagger-parser');
// const mergeAllOf = require('json-schema-merge-allof');
const fs = require('fs');
YAML = require('yamljs');

/**
 * $refを取り除き、allOfを展開してファイル出力
 * https://qiita.com/yuya_sega/items/508d623b32fb5faa52e3
 * @param {*} inputFilePath 
 * @param {*} outputFilePath 
 */
async function processOpenAPISchema(inputFilePath, outputFilePath) {
  try {
    // OpenAPI仕様をデリファレンス
    const api = await SwaggerParser.dereference(inputFilePath);

    // allOfを展開し、順序を保ったスキーマを作成する関数
    function processSchema(schema) {
      if (schema && typeof schema === 'object') {
        // if (schema.allOf) {
        //   schema = mergeAllOf(schema, { resolvers: {} });
        // }
        for (const key in schema) {
          schema[key] = processSchema(schema[key]);
        }
        if (schema.type === 'object') {
          return {
            type: schema.type,
            properties: schema.properties,
            required: schema.required,
          };
        }
      }
      return schema;
    }

    // デリファレンスされたAPI全体を処理
    const processedApi = processSchema(api);

    // 結果をファイルに書き出す
    // YAML.stringifyの第二引数depthは無根拠にいい感じの数値を入れています
    // ファイル側のネストが深くなったら壊れるかも
    fs.writeFileSync(outputFilePath, YAML.stringify(processedApi, 15, 2));
    console.log('Processed OpenAPI schema written to', outputFilePath);
  } catch (err) {
    console.error('Error processing OpenAPI schema:', err);
  }
}

processOpenAPISchema('src/index.yaml', 'openapi.yaml');
