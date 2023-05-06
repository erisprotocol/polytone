// const npsUtils = require("nps-utils"); // not required, but handy!

module.exports = {
  scripts: {
    release: {
      default: "bash build_release.sh",
    },
    schema: {
      default:
        "nps schema.create schema.transform schema.note schema.proxy schema.voice ",

      transform: "ts-node transform.ts",

      create: "bash build_schema.sh",

      note: "cd .. && json2ts -i contracts/main/note/**/*.json -o ../liquid-staking-scripts/types/polytone_note",
      proxy:
        "cd .. && json2ts -i contracts/main/proxy/**/*.json -o ../liquid-staking-scripts/types/polytone_proxy",
      voice:
        "cd .. && json2ts -i contracts/main/voice/**/*.json -o ../liquid-staking-scripts/types/polytone_voice",
    },
  },
};
