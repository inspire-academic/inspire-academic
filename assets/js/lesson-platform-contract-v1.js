(function (root, factory) {
  const api = factory();
  if (typeof module === 'object' && module.exports) module.exports = api;
  else root.INSPIRE_LESSON_PLATFORM_V1 = api;
})(typeof globalThis !== 'undefined' ? globalThis : this, function () {
  'use strict';

  const VERSION = 1;
  const BLOCK_TYPES = Object.freeze([
    'explanation',
    'worked-example',
    'question',
    'diagram',
    'assessment',
    'simulation'
  ]);
  const adapters = new Map();

  function nonEmpty(value) {
    return typeof value === 'string' && value.trim().length > 0;
  }

  function validateBlock(block, index, errors) {
    const at = `blocks[${index}]`;
    if (!block || typeof block !== 'object' || Array.isArray(block)) {
      errors.push(`${at} must be an object`);
      return;
    }
    if (!nonEmpty(block.id)) errors.push(`${at}.id is required`);
    if (!BLOCK_TYPES.includes(block.type)) errors.push(`${at}.type is unsupported`);
    if (!Number.isInteger(block.order) || block.order < 1) errors.push(`${at}.order must be a positive integer`);
    if (!nonEmpty(block.learningGoal)) errors.push(`${at}.learningGoal is required`);
    if (block.tier !== undefined && !['Both', 'Foundation', 'Higher'].includes(block.tier)) {
      errors.push(`${at}.tier is invalid`);
    }
    if (block.type !== 'simulation') return;
    if (!nonEmpty(block.componentId)) errors.push(`${at}.componentId is required`);
    if (!block.inputs || typeof block.inputs !== 'object' || Array.isArray(block.inputs)) {
      errors.push(`${at}.inputs must be an object`);
    }
    if (!block.fallback || !['text', 'diagram', 'static'].includes(block.fallback.kind) ||
        !nonEmpty(block.fallback.content)) {
      errors.push(`${at}.fallback must provide kind and content`);
    }
    if (!block.accessibility || !nonEmpty(block.accessibility.label) ||
        !nonEmpty(block.accessibility.description)) {
      errors.push(`${at}.accessibility must provide label and description`);
    }
  }

  function validate(contract) {
    const errors = [];
    if (!contract || typeof contract !== 'object' || Array.isArray(contract)) {
      return { valid: false, errors: ['contract must be an object'] };
    }
    if (contract.schemaVersion !== VERSION) errors.push(`schemaVersion must be ${VERSION}`);
    if (!nonEmpty(contract.lessonId)) errors.push('lessonId is required');
    if (!nonEmpty(contract.subject)) errors.push('subject is required');
    if (!nonEmpty(contract.title)) errors.push('title is required');
    if (!Array.isArray(contract.blocks) || contract.blocks.length === 0) {
      errors.push('blocks must contain at least one block');
    } else {
      contract.blocks.forEach((block, index) => validateBlock(block, index, errors));
      const ids = contract.blocks.map(block => block && block.id).filter(Boolean);
      if (new Set(ids).size !== ids.length) errors.push('block ids must be unique');
      const orders = contract.blocks.map(block => block && block.order).filter(Number.isInteger);
      if (new Set(orders).size !== orders.length) errors.push('block order values must be unique');
    }
    return { valid: errors.length === 0, errors };
  }

  function registerAdapter(componentId, adapter) {
    if (!nonEmpty(componentId)) throw new TypeError('componentId is required');
    if (!adapter || typeof adapter.mount !== 'function') {
      throw new TypeError('adapter.mount must be a function');
    }
    adapters.set(componentId, adapter);
    return function unregister() { adapters.delete(componentId); };
  }

  function resolveSimulation(block) {
    const errors = [];
    validateBlock(block, 0, errors);
    if (errors.length) return { mode: 'fallback', fallback: block && block.fallback, errors };
    const adapter = adapters.get(block.componentId);
    return adapter
      ? { mode: 'interactive', adapter, inputs: block.inputs }
      : { mode: 'fallback', fallback: block.fallback, errors: [] };
  }

  return Object.freeze({ VERSION, BLOCK_TYPES, validate, registerAdapter, resolveSimulation });
});
