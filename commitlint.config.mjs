export default {
    extends: ['@commitlint/config-conventional'],
    rules: {
        // Disable cased enforcent for subjects
        'subject-case': [0],
    },
};
